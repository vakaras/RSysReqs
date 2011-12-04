default: buildout

bootstrap.py:
	wget http://svn.zope.org/*checkout*/zc.buildout/trunk/bootstrap/bootstrap.py

bin/buildout: bootstrap.py
	python bootstrap.py --distribute

buildout: bin/buildout
	bin/buildout -v
