from flask import g
from debug import *

import os
import rpclib
import traceback

sys.path.append(os.getcwd())
import readconf

def run_profile(user):
    try:
        pcode = user.profile
        pcode = pcode.replace('\r\n', '\n')

        ## Uncomment the code below when you start getting the profile server working:
        # host = readconf.read_conf().lookup_host('profile')
        # with rpclib.client_connect(host) as c:
        #     return c.call('run', pcode=pcode,
        #                          user= user.username,
        #                          visitor=g.user.person.username)

        ## Stub implementation that works without a separate profile server:
        import api, io, sys, importlib
        ps = importlib.import_module("profile-server")
        api.api_stub = ps.ProfileAPIServer(user, g.user.person.username, pcode)
        code = compile(pcode, "<profile>", "exec")

        buf = io.StringIO()
        old_stdout = sys.stdout
        old_stderr = sys.stderr
        sys.stdout = buf
        sys.stderr = buf
        try:
            eval(code)
        finally:
            sys.stdout = old_stdout
            sys.stderr = old_stderr
        return buf.getvalue()
    except Exception as e:
        traceback.print_exc()
        return 'Exception: ' + str(e)
