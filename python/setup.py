from setuptools import setup
from Cython.Build import cythonize
setup(
    ext_modules = cythonize("pyx/robot.pyx"),
    compiler_directives={'language_level' : 3}
)
from setuptools import setup
from Cython.Build import cythonize
setup(
    ext_modules = cythonize("pyx/robot.pyx"),
    compiler_directives={'language_level' : 3}
)
