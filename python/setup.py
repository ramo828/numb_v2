from setuptools import setup
from Cython.Build import cythonize
setup(
    ext_modules = cythonize("pyx/bklib.pyx"),
    compiler_directives={'language_level' : 3}
)
setup(
    ext_modules = cythonize("pyx/robot.pyx"),
    compiler_directives={'language_level' : 3}
)

setup(
    ext_modules = cythonize("pyx/numb_lib.pyx"),
    compiler_directives={'language_level' : 3}
)

setup(
    ext_modules = cythonize("pyx/statistic.pyx"),
    compiler_directives={'language_level' : 3}
)
