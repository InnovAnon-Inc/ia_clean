#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" Clean Source Directory """

import asyncio
from pathlib                                 import Path
import shutil
from typing                                  import List

import dotenv
from structlog                               import get_logger

logger                                     = get_logger()

def main()->None:
	requirements_txt:Path = Path('requirements.txt')
	assert requirements_txt.is_file()

	#with requirements_txt.open('r',) as f:
	#	ignores:List[str] = f.readlines()

	ignore_dirs:List[str] = ['__pycache__', '.tox', 'build', 'dist', '*.egg-info',]
	ignore_files:List[str] = ['*.cpp', '*.spec',]
	for root,dirs,files in Path().walk():
		for d in dirs:
			path:Path = root / d
			assert path.is_dir()
			for ignore_dir in ignore_dirs:
				if path.match(ignore_dir):
					logger.debug('rmtree %s (%s)', ignore_dir, path,)
					shutil.rmtree(path)
					break

		for f in files:
			path:Path = root / f
			assert path.is_file()
			for ignore_file in ignore_files:
				if path.match(ignore_file):
					logger.debug('unlink %s (%s)', ignore_file, path,)
					path.unlink()
					break

if __name__ == '__main__':
	main()

__author__:str = 'you.com' # NOQA
