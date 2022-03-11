echo "from setuptools import setup" >> setup.py
echo "from Cython.Build import cythonize" >> setup.py
echo "setup(" >> setup.py
echo "    ext_modules = cythonize(\"pyx/robot.pyx\")," >> setup.py
echo "    compiler_directives={'language_level' : 3}" >> setup.py
echo ")"  >> setup.py

