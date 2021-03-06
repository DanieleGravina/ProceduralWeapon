"""
Example of creating a radar chart (a.k.a. a spider or star chart) [1]_.

Although this example allows a frame of either 'circle' or 'polygon', polygon
frames don't have proper gridlines (the lines are circles instead of polygons).
It's possible to get a polygon grid by setting GRIDLINE_INTERPOLATION_STEPS in
matplotlib.axis to the desired number of vertices, but the orientation of the
polygon is not aligned with the radial axes.

.. [1] http://en.wikipedia.org/wiki/Radar_chart
"""
import numpy as np

import matplotlib.pyplot as plt
from matplotlib.path import Path
from matplotlib.spines import Spine
from matplotlib.projections.polar import PolarAxes
from matplotlib.projections import register_projection

from Costants import *
from math import *

limits = [(0, log(1/(ROF_MIN/100))*2), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

def normalize(data):
    for j in range(10):
        data[j] = (data[j] - limits[j][0])/(limits[j][1] - limits[j][0])

    return data

def postProcess(data):

    #fireinterval become rate of fire -> (1/fireinterval)
    data[0] = log(1/(ROF_MIN/100)) + log(1/data[0])

    #gravity is inverted
    data[8] = - data[8]

    return data


def radar_factory(num_vars, frame='circle'):
    """Create a radar chart with `num_vars` axes.

    This function creates a RadarAxes projection and registers it.

    Parameters
    ----------
    num_vars : int
        Number of variables for radar chart.
    frame : {'circle' | 'polygon'}
        Shape of frame surrounding axes.

    """
    # calculate evenly-spaced axis angles
    theta = 2*np.pi * np.linspace(0, 1-1./num_vars, num_vars)
    # rotate theta such that the first axis is at the top
    theta += np.pi/2

    def draw_poly_patch(self):
        verts = unit_poly_verts(theta)
        return plt.Polygon(verts, closed=True, edgecolor='k')

    def draw_circle_patch(self):
        # unit circle centered on (0.5, 0.5)
        return plt.Circle((0.5, 0.5), 0.5)

    patch_dict = {'polygon': draw_poly_patch, 'circle': draw_circle_patch}
    if frame not in patch_dict:
        raise ValueError('unknown value for `frame`: %s' % frame)

    class RadarAxes(PolarAxes):

        name = 'radar'
        # use 1 line segment to connect specified points
        RESOLUTION = 1
        # define draw_frame method
        draw_patch = patch_dict[frame]

        def fill(self, *args, **kwargs):
            """Override fill so that line is closed by default"""
            closed = kwargs.pop('closed', True)
            return super(RadarAxes, self).fill(closed=closed, *args, **kwargs)

        def plot(self, *args, **kwargs):
            """Override plot so that line is closed by default"""
            lines = super(RadarAxes, self).plot(*args, **kwargs)
            for line in lines:
                self._close_line(line)

        def _close_line(self, line):
            x, y = line.get_data()
            # FIXME: markers at x[0], y[0] get doubled-up
            if x[0] != x[-1]:
                x = np.concatenate((x, [x[0]]))
                y = np.concatenate((y, [y[0]]))
                line.set_data(x, y)

        def set_varlabels(self, labels):
            self.set_thetagrids(theta * 180/np.pi, labels)

        def _gen_axes_patch(self):
            return self.draw_patch()

        def _gen_axes_spines(self):
            if frame == 'circle':
                return PolarAxes._gen_axes_spines(self)
            # The following is a hack to get the spines (i.e. the axes frame)
            # to draw correctly for a polygon frame.

            # spine_type must be 'left', 'right', 'top', 'bottom', or `circle`.
            spine_type = 'circle'
            verts = unit_poly_verts(theta)
            # close off polygon by repeating first vertex
            verts.append(verts[0])
            path = Path(verts)

            spine = Spine(self, spine_type, path)
            spine.set_transform(self.transAxes)
            return {'polar': spine}

    register_projection(RadarAxes)
    return theta


def unit_poly_verts(theta):
    """Return vertices of polygon for subplot axes.

    This polygon is circumscribed by a unit circle centered at (0.5, 0.5)
    """
    x0, y0, r = [0.5] * 3
    verts = [(r*np.cos(t) + x0, r*np.sin(t) + y0) for t in theta]
    return verts


def get_data(weapons):

    data = {
        'column names':
            ['RoF', 'Spread', 'Ammo', 'ShotCost', 'LifeSpan', 'Speed', 'Dmg', 'DmgRad',
             'Grav', 'Exp']
             }

    i = 0
    for weap in weapons :
        i += 1
        data.update( {'Generated Weapon' : [normalize(weap)] } )

    data.update({'Target Weapon' : [normalize(postProcess([1.1,   0.1,   30,      9,     2, 3500,  18,       20,      0, 0]))]})

    return data


def draw_radar(weapons, color_cluster, fitness_cluster, num_samples):

    N = 10
    theta = radar_factory(N, frame='polygon')

    data = get_data(weapons)
    spoke_labels = data.pop('column names')

    fig = plt.figure(figsize=(16, 9))
    fig.subplots_adjust(wspace=0.50, hspace=0.20)

    colors = ['b', 'r', 'g', 'm', 'y']
    # Plot the four cases from the example data on separate axes
    for n, title in enumerate(data.keys()):
        ax = fig.add_subplot(1, 4, n+1, projection='radar')
        plt.rgrids([0.5], (''))

        ax.set_title(title, weight='bold', size='medium', position=(0.5, 1.1),
                     horizontalalignment='center', verticalalignment='center')

        for d, color in zip(data[title], colors):
            ax.plot(theta, d, color=color_cluster)
            ax.fill(theta, d, facecolor=color_cluster, alpha=0.25)
        ax.set_varlabels(spoke_labels)

    ax = fig.add_subplot(1, 4, 3)

    plt.ylim(0, 3)
    ax.set_title("Balance")
    ax.boxplot( [fitness_cluster[i][0] for i in range(len(fitness_cluster))] )

    ax = fig.add_subplot(1, 4, 4)

    plt.ylim(0, 0.5)
    ax.set_title("Distance from target")
    ax.boxplot( [fitness_cluster[i][1] for i in range(len(fitness_cluster))] )

    # add legend relative to top-left plot
    '''
    plt.subplot(2, 2, 1)
    labels = ('Factor 1')
    legend = plt.legend(labels, loc=(0.9, .95), labelspacing=0.1)
    plt.setp(legend.get_texts(), fontsize='small')
    '''

    plt.figtext(0.5, 0.965, 'Mean of clustered weapon, num samples = ' + str(num_samples),
                ha='center', color='black', weight='bold', size='large')
    #plt.show()
