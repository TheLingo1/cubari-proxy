# Cubari Proxy
## Changes made in this fork:

- Changed source parameter for proxy service url in resizedImageUrl() in src/sources/SourceUtils.ts
- Changed source parameter for proxy service url in requestInterceptor and CubariSourceMixin() in src/sources/CubariSource.ts
- Changed the cors/image proxy service used to my self hosted one (the default one only allows official origins) at cubari-proxy-services.gabjimmy.com in src/sources/SourceUtils.ts
- Changed the package.json to use cross-env in the start and build scripts
- Changed the theme setting in local storage to be forcibly set to dark on startup (fixed an issue with it defaulting to system and breaking) in src/components/ThemeSwitcher.js 
- Updated package-lock to use the proper axios version and have cross-env (even though it already had the axios version in there? didn't work before idk)
- Made a dockerfile and a .dockerignore


## Deploying
To host this yourself, you just need to build the docker image and deploy it.

to build docker image:
```
docker build -t ghcr.io/USERNAME/cubari:latest .
```

to push it to ghcr:
```
docker push ghcr.io/thelingo1/cubari:latest
```

## Proxy Services
If nothing loads and instead you see the loading circle spinning forever, this is most likely due to the proxy service (a self hosted one I use at cubari-proxy-services.gabjimmy.com) not allowing the request (CORS origin). 

To fix this you will have to host the proxy service yourself.
First clone the proxy services repo (originally from funkyhippo)
```
git clone https://github.com/funkyhippo/cubari-proxy-services.git
```

Then edit `src/routes/v1/cors.js` and `src/routes/v2/cors.js` to have your self hosted cubari domain in the list of allowed hosts (modify [this](https://github.com/funkyhippo/cubari-proxy-services/blob/cfbd58fc8be3cfa04b16f6a14c658645da36cc3b/src/routes/v1/cors.js#L16) object).

Then build the docker image for that as well (same commands as above but name it something other than cubari) and run it.

Finally you will need to change the PROXY_URL in `src/sources/SourceUtils.ts` to be the address you're hosting the proxy service at.  
