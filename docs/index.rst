.. flask-csrf documentation master file, created by
   sphinx-quickstart on Tue May 11 18:54:04 2010.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to flask-csrf's documentation!
======================================

The internet is a dangerous place. One common type of attack your site's users
can fall victim to is `Cross-Site Request Forgery`_ attacks.

flask-csrf is a small extension to Flask that makes adding CSRF protection to
your `Flask`_ application quick and easy.  It's based on `this snippet`_ from
the Flask snippet site.

.. _Cross-Site Request Forgery: http://www.squarefree.com/securitytips/web-developers.html#CSRF
.. _Flask: http://flask.pocoo.org/
.. _this snippet: http://flask.pocoo.org/snippets/3/

Installation
------------

Install flask-csrf with `pip`_::

    pip install -e 'hg+http://bitbucket.org/sjl/flask-csrf@v0.9.0#egg=flask-csrf'

Prefer `git`_ to `Mercurial`_?

::

    pip install -e 'git+http://github.com/sjl/flask-csrf.git@v0.9.0#egg=flask-csrf'

.. _pip: http://pip.openplans.org/
.. _git: http://git-scm.com/
.. _Mercurial: http://hg-scm.org/

Usage
-----

To activate CSRF protection for your Flask application you need to do two
things. First, call the ``csrf`` function with your Flask app as a parameter::

    from flaskext.csrf import csrf
    csrf(app)

Once you do that you'll need to add a CSRF token to every form on your site
that makes an HTTP ``POST`` request::

    <input type="hidden" value="{{ csrf_token() }}">

If you have certain views that need to be excluded from this protection
(perhaps they receive ``POST`` requests from a third-party site) you can use
the ``csrf_exempt`` decorator to disable protection::

    from flaskext.csrf import csrf, csrf_exempt
    
    @csrf_exempt
    @route('/foo/')
    def my_receiving_view():
        # ...
    
    csrf(app)

If for some reason you want to know *when* a CSRF attack happens, you can pass
a function to the ``csrf`` call and it will be called whenever an attack is
detected::

    from flaskext.csrf import csrf
    
    attacks = 0
    def count_csrf_attacks(endpoint, arguments):
        attacks += 1
    
    csrf(app, on_csrf=count_csrf_attacks)

This function must take two parameters:


-  **endpoint** - A string representing the view that would
   normally handle this request.
-  **arguments** - The arguments that would normally be passed (if
   any) to that view.

You can use this function to do anything you like; counting attacks is just
a simple example.

Contribute
----------

flask-csrf is open source and MIT licensed.  If you want to contribute feel
free to fork the `Mercurial repository`_ or `git repository`_ and send a pull
request.

.. _Mercurial repository: http://bitbucket.org/sjl/flask-csrf/
.. _git repository: http://github.com/sjl/flask-csrf/
