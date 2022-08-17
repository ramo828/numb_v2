#cython: language_level=3

from setuptools import setup
from distutils.core import setup
from Cython.Build import cythonize
setup(
    name = 'numb_v2',
    ext_modules = cythonize(["pyx/*.pyx"]),
    compiler_directives={'language_level' : 3},
)
