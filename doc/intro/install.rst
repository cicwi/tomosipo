Install tomosipo
================

A minimal installation requires:

* python >= 3.10
* ASTRA-toolbox >= 2.0
* GPU supporting CUDA

Minimal installation
--------------------

We recommend using `conda <https://docs.conda.io/en/latest/>`_ to install the required dependencies.
The following commands create a new environment named ``tomosipo`` and install tomosipo from GitHub:

.. code-block:: bash

   conda create -n tomosipo python=3.10 pip astra-toolbox -c conda-forge
   conda activate tomosipo
   pip install git+https://github.com/cicwi/tomosipo.git

.. _intro_install_with_pytorch:

Installation with optional dependencies
---------------------------------------

To use tomosipo with PyTorch, CuPy, Qt, and `ts_algorithms <https://github.com/ahendriksen/ts_algorithms>`_,
install:

.. code-block:: bash

    conda create -n tomosipo astra-toolbox pytorch cupy pyqtgraph pyqt pyopengl -c conda-forge
    conda activate tomosipo
    pip install git+https://github.com/cicwi/tomosipo
    pip install git+https://github.com/ahendriksen/ts_algorithms
