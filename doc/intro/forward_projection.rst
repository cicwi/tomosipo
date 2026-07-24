.. _intro_forward_projection:

Creating a tomographic projection
=================================

.. note::
   To keep the size of the documentation in version control manageable, we do not
   include images of the volume and the reconstruction. It is recommended to follow
   along in your favorite Python environment so you can see what is going on.

In this walkthrough, we will create tomographic projections using tomosipo. First, we
import the necessary packages. By convention, ``tomosipo`` is imported as ``ts``:

.. testcode:: session

   import tomosipo as ts
   import numpy as np

Now we can create a volume and a circular parallel-beam projection geometry. The volume
is a three-dimensional unit cube and is composed of 32 voxels in each dimension. The
parallel-beam geometry has 32 angles that are equi-spaced over a half arc. The detector
has 48 pixels in each dimension and has both height and width of 1.5 units.

.. testcode:: session

   vg = ts.volume(shape=(32, 32, 32), size=(1, 1, 1))
   pg = ts.parallel(angles=32, shape=(48, 48), size=(1.5, 1.5))

If the ``size`` argument is omitted, a volume geometry uses unit voxel sizes, so
its physical size matches its shape. See :meth:`tomosipo.volume` for details.
Similarly, projection geometries use unit detector pixels by default. Instead of
specifying the number of angles, you can also pass an array of angles directly.
See :meth:`tomosipo.parallel` for more information.

The geometries have readable string representations, so we can inspect what we created:

.. doctest:: session

   >>> print(vg)
   ts.volume(
       shape=(32, 32, 32),
       pos=(0.0, 0.0, 0.0),
       size=(1.0, 1.0, 1.0),
   )
   >>> pg    # or just press enter in the Python console..
   ts.parallel(
       angles=32,
       shape=(48, 48),
       size=(1.5, 1.5),
   )

In addition, we can display the geometry as an SVG animation:

.. testcode:: session

   svg = ts.svg(vg, pg)
   svg.save("./doc/img/intro_forward_projection_geometries.svg")

.. figure:: ../img/intro_forward_projection_geometries.svg
   :width: 400
   :alt: A parallel beam geometry rotating through a small volume.


As you can see, in our geometry definition the detector overlaps with the volume.
Although this is physically impossible, this is not a problem because the projection
operator takes into account ray-volume intersections both behind and in front of the
detector.

A projection operator can be created as follows:

.. testcode:: session

   A = ts.operator(vg, pg)

The operator has two useful properties, ``domain_shape`` and ``range_shape``, which can
be used to create volume and projection data:

.. doctest:: session

   >>> A.domain_shape, A.range_shape
   ((32, 32, 32), (48, 32, 48))
   >>> x = np.ones(A.domain_shape, dtype=np.float32)

As you can see, the projection data is stored as a stack of sinograms, following the
ASTRA-toolbox convention. The first dimension is the detector height, the second is the
projection angle, and the third is the detector width.

Now, we can create a projection by applying the operator to the data ``x``:

.. doctest:: session
   :skipif: not cuda_available

   >>> y = A(x)
   >>> y.shape
   (48, 32, 48)

You can take a look at the projections using matplotlib.

.. testcode:: session
   :skipif: (not cuda_available) or (not matplotlib_available)

   import matplotlib.pyplot as plt
   plt.imshow(y[:, 0, :]) # first projection
   plt.imshow(y[:, 8, :]) # quarter rotation

Proceed to the :ref:`next tutorial <intro_simple_reconstruction>` to see how to
compute a reconstruction from these projection data.
