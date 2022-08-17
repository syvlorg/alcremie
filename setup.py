# -*- coding: utf-8 -*-
from setuptools import setup

packages = \
['alcremie']

package_data = \
{'': ['*']}

install_requires = \
['bakery @ git+https://github.com/syvlorg/bakery.git@main']

setup_kwargs = {
    'name': 'alcremie',
    'version': '2.0.0.0',
    'description': 'Macros for the bakery!',
    'long_description': None,
    'author': 'sylvorg',
    'author_email': 'jeet.ray@syvl.org',
    'maintainer': None,
    'maintainer_email': None,
    'url': None,
    'packages': packages,
    'package_data': package_data,
    'install_requires': install_requires,
    'python_requires': '>=3.9,<3.11',
}


setup(**setup_kwargs)

