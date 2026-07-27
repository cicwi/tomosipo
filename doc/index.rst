===========================================================================
Tomosipo
===========================================================================

Tomosipo is a Pythonic interface to the `ASTRA Toolbox <https://astra-toolbox.com>`_
for flexible, high-performance 3D tomography. It aims to:

- Expose a user-friendly API for 3D tomography without compromising performance or flexibility;
- Enable convenient definition, manipulation and visualisation of complex 3D geometries;
- Provide easy integration with other libraries and frameworks, such as PyTorch.

If you are looking for reconstruction algorithms built on top of Tomosipo, see
`ts_algorithms <https://github.com/ahendriksen/ts_algorithms>`_.

Install
=======

Minimal installation
--------------------

We recommend using `conda <https://docs.conda.io/en/latest/>`_ to install the required dependencies.
The following commands create a new environment named ``tomosipo`` and install tomosipo from GitHub:

.. code-block:: bash

   conda create -n tomosipo -c conda-forge astra-toolbox
   conda activate tomosipo
   pip install git+https://github.com/cicwi/tomosipo.git

.. _intro_install_with_pytorch:

Installation with optional dependencies
---------------------------------------

To use tomosipo with PyTorch, and `ts_algorithms <https://github.com/ahendriksen/ts_algorithms>`_,
install:

.. code-block:: bash

    conda create -n tomosipo -c conda-forge astra-toolbox pytorch
    conda activate tomosipo
    pip install git+https://github.com/cicwi/tomosipo
    pip install git+https://github.com/ahendriksen/ts_algorithms

First steps
===========

- :doc:`intro/forward_projection`
- :doc:`intro/simple_reconstruction`
- Advanced tutorials:

  - :doc:`intro/fast_reconstruction`
  - :doc:`intro/lab_frame`

How the documentation is organized
==================================

Tomosipo has different types of documentation:

* :doc:`Tutorials </intro/index>` are detailed walk-through guides. Start here if you're
  new to tomosipo or tomography.

* :doc:`In-depth guides </topics/index>` discuss key concepts at a high level and
  provide useful background information and explanation.

* :doc:`Short recipes </howto/index>` explain how to perform common tasks assuming some
  knowledge of tomosipo.

* :doc:`API reference </ref/index>` is an extensive technical reference for tomosipo.

Other resources
===============

Video
-----

* `CWI Tomosipo Tutorial (21-Jun-2021) <https://www.youtube.com/watch?v=biStJB1zb-Y>`_

Blog
----

* `Modeling Cryo-EM using tomosipo <https://blog.allardhendriksen.nl/cwi-ci-group/modeling_cry_em_using_tomosipo/>`_
* `Chambolle-Pock algorithm on the GPU using tomosipo <https://blog.allardhendriksen.nl/cwi-ci-group/chambolle_pock_using_tomosipo/>`_
* `Tomosipo reconstruction on the GPU <https://blog.allardhendriksen.nl/cwi-ci-group/advent-of-tomosipo-s003_gpu_reconstruction/>`_


.. toctree::
   :hidden:

   Overview <self>
   intro/index
   topics/index
   howto/index
   ref/index
   changelog
