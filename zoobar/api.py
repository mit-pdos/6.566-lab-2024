import rpclib

## Stub implementation of the API for insecure Python profiles:
api_stub = None

def call(method, **kwargs):
    ## Uncomment the following code to access the API server over RPC,
    ## when you start getting the profile server working:
    # with rpclib.RpcClientFifo('/run/fifo') as c:
    #     return c.call(method, **kwargs)

    ## Stub implementation that works without the profile server:
    global api_stub
    m = api_stub.__getattribute__('rpc_' + method)
    return m(**kwargs)
