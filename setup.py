from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize
import os

extra_compile_args = os.getenv("EXTRA_COMPILE_ARGS", "").split()
extra_link_args = os.getenv("EXTRA_LINK_ARGS", "").split()

setup(
    name = "python-gdsl",
    version = "0.0.0",
    description = "A Python port for gdsl-toolkit using Cython",
    author = "Tomonori Izumida",
    author_email = "tizmd@iij.ad.jp",
    packages = ["rreil"],
    install_requires = [
        'six',
        'enum34;python_version<"3.4"',
    ],
    ext_modules = cythonize([Extension("gdsl", ["src/gdsl.pyx"],
                                       extra_compile_args = extra_compile_args,
                                       extra_link_args = extra_link_args,
                                       libraries = ["multiplex"]),
                             Extension("gdrr_builder", ["src/gdrr_builder.pyx"],
                                       extra_compile_args = extra_compile_args,
                                       extra_link_args = extra_link_args)
                             ], include_path=["src"]),
    package_dir = { "":"src" },
    tests_require = ['nose'],
    test_suite = 'nose.collector'
)
