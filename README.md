# *New* Clay bindings for C3

C3 Bindings, working for version 0.7.3 of C3 & version 0.14 of [Clay](https://github.com/nicbarker/clay).

## To Use:

1. Set up your c3 project.
2. Download current version of bindings from release (or grab them from this repos lib folder).
3. Currently bindings rely on Raylib for the raylib renderer, so vendor-fetch "raylib55" (will add other renderers at some point).
- `c3c vendor-fetch raylib55`
4. Put the downloaded Clay bindings in your projects 'lib' folder. That's whatever folder raylib ended up in.
5. Add "clay" to your project.json (again, same place as raylib). should end up looking something like below:
```JSON
"dependency-search-paths":  [ "lib"],
"dependencies":  [ "raylib55", "clay" ],
```
6. Now you can import Clay! 

## For this repo

to view the original [video_demo](https://youtu.be/DYWTw19_8r4?si=aByPTxXC0sSKJJkr) written in Clay 0.11:
```
c3c run old-example   
```

to see the original demo rewritten in Clay 0.14 bindings (the new ones):
```
c3c run new-example   
```

To try and just get an all black window popup (baseline), in case something is really wrong with the two above:   
```
c3c run main
```   
or `c3c run`

You can also press `D` in any of the above builds to enable clays debug window!

> [!WARNING]  
> This probably isn't finished yet, but it's usable! Changes will be made on new releases of Clay... when I get to them!
