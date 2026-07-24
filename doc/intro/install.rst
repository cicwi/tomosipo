Install tomosipo
================

A minimal installation requires:

* python >= 3.10
* ASTRA-toolbox >= 2.0
* GPU supporting CUDA

Install the latest Git version
------------------------------

First, install the requirements using the `conda <https://docs.conda.io/en/latest/>`_
package manager. The following snippet creates a new conda environment named `tomosipo`:

.. code-block:: bash

   conda create -n tomosipo astra-toolbox -c conda-forge

After activating the environment containing the dependencies, install tomosipo using pip:

.. code-block:: bash

    conda activate tomosipo
    pip install git+https://github.com/cicwi/tomosipo

Install optional dependencies
-----------------------------

To use tomosipo with PyTorch, cupy, Qt, and `ts_algorithms <https://github.com/ahendriksen/ts_algorithms>`_,
install:

.. code-block:: bash

    conda create -n tomosipo astra-toolbox pytorch cupy pyqtgraph pyqt pyopengl cupy -c conda-forge
    conda activate tomosipo
    pip install git+https://github.com/cicwi/tomosipo
    pip install git+https://github.com/ahendriksen/ts_algorithms
