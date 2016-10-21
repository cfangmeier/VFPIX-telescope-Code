from setuptools import setup

setup(
    name='STF',
    version='0.1',
    py_modules=[
        'app.daq_board',
        'app.assembly',
        'app.utils',
        'app.cli',
        ],
    install_requires=[
        'Click',
        'enum34',
        'ipython',
        ],
    entry_points='''
        [console_scripts]
        assemble=app.assembly:assemble
        compile=app.assembly:compile
        stf=app.cli:stf
    ''',
)
