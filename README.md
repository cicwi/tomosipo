<h1 align="center">
<img src="https://raw.githubusercontent.com/cicwi/tomosipo/master/doc/img/logo_title.svg" width="300">
</h1><br>

[![DOI badge](https://img.shields.io/badge/DOI-10.1364%2Foe.439909-blue)](https://doi.org/10.1364/oe.439909)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-orange.svg)](https://www.gnu.org/licenses/gpl-3.0)

Tomosipo is a Pythonic interface to the [ASTRA Toolbox](https://astra-toolbox.com) for
flexible, high-performance 3D tomography. It aims to:

-   Expose a user-friendly API for 3D tomography without compromising performance or flexibility
-   Enable convenient definition, manipulation and visualization of complex 3D geometries
-   Provide easy integration with other libraries and frameworks, such as PyTorch.

If you are looking for reconstruction algorithms built on top of Tomosipo, see
[ts_algorithms](https://github.com/ahendriksen/ts_algorithms).

# Installation

We recommend using [conda](https://docs.conda.io/en/latest/) to install tomosipo. An
installation with tomosipo, Pytorch, and [ts_algorithms](https://github.com/ahendriksen/ts_algorithms)
can be created with the following snippet:

```bash
conda create -n tomosipo -c conda-forge astra-toolbox pytorch
conda activate tomosipo
pip install git+https://github.com/cicwi/tomosipo.git
pip install git+https://github.com/ahendriksen/ts_algorithms.git
```

More information about installation is provided in the [documentation](https://cicwi.github.io/tomosipo/index.html#install).

# Usage

Please refer to the [documentation](https://cicwi.github.io/tomosipo/index.html) and the
[`examples/`](https://github.com/cicwi/tomosipo/tree/master/examples) directory. An
introduction and demonstration of tomosipo can also be found in the associated [Optics
Express](https://doi.org/10.1364/oe.439909) paper.

## Create and visualize geometries

You can also follow along in
[Google Colab](https://colab.research.google.com/github/cicwi/tomosipo/blob/master/notebooks/google_colab.ipynb).

```python
import numpy as np
import tomosipo as ts

# Create a cone-beam geometry
pg = ts.cone(angles=20, size=np.sqrt(2), cone_angle=0.5)
print(pg)

# Create a unit volume centered at the origin
vg = ts.volume()
print(vg)

# Display the acquisition geometry as an SVG animation
scene = ts.svg(pg, vg)
scene
```

## Express algorithms succinctly

In the following example, we implement the simultaneous iterative reconstruction
algorithm (SIRT) in a couple of lines of code. This example demonstrates the use of the
forward and backward projection, and integration with PyTorch.

```python
import tomosipo as ts
import torch

device = "cuda" if torch.cuda.is_available() else "cpu"

# Create the geometries
vg = ts.volume(shape=128)
pg = ts.cone(shape=128, cone_angle=0.5, angles=100)

# Create the projection operator
A = ts.operator(vg, pg)

# Create a simple phantom (a small cube)
phantom = torch.zeros(A.domain_shape, device=device)
phantom[20:50, 20:50, 20:50] = 1.0

# Compute the sinogram
y = A(phantom)

# Prepare the standard SIRT preconditioners
R = 1 / A(torch.ones(A.domain_shape, device=device))
R = torch.minimum(R, 1 / ts.epsilon)
C = 1 / A.T(torch.ones(A.range_shape, device=device))
C = torch.minimum(C, 1 / ts.epsilon)

# Reconstruct from y in 100 iterations
x_rec = torch.zeros(A.domain_shape, device=device)
num_iters = 100

for _ in range(num_iters):
    x_rec += C * A.T(R * (y - A(x_rec)))
```

A similar implementation of SIRT and succinct implementations of some other
reconstruction algorithms are available in the
[ts_algorithms](https://github.com/ahendriksen/ts_algorithms) library.

# Citing tomosipo

If you use tomosipo in scientific publications, we would appreciate citations
of [our paper](https://doi.org/10.1364/oe.439909) using the following Bibtex
entry:

``` bibtex
@Article{hendriksen-2021-tomos,
  author          = {Hendriksen, Allard and Schut, Dirk and Palenstijn, Willem
                  Jan and Viganò, Nicola and Kim, Jisoo and Pelt, Dani{\"e}l and
                  van Leeuwen, Tristan and Batenburg, K. Joost},
  title           = {Tomosipo: Fast, Flexible, and Convenient {3D} Tomography for
                  Complex Scanning Geometries in {Python}},
  journal         = {Optics Express},
  year            = 2021,
  doi             = {10.1364/oe.439909},
  url             = {https://doi.org/10.1364/oe.439909},
  issn            = {1094-4087},
  month           = {Oct},
  publisher       = {The Optical Society},
}
```

# Authors and contributors

tomosipo is developed by the Computational Imaging group at CWI.

Original author:

-   **Allard Hendriksen**

Current maintainer:

-   **Alexander Skorikov**

We thank the following authors for their contribution

-   **Johannes Leuschner** - ODL integration
-   **Dirk Schut** - various features and for the long time maintenance of the package

See also the list of contributors who participated in this project.
