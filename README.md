# c³ demos

Demos of [c³](https://github.com/SEAMWARE/c3), the coraine Control Center, on
[coraine](https://github.com/SEAMWARE/coraine) brokers - to watch, or to run on your machine.

Online: **https://seamware.github.io/c3-demos/**

| Demo | What it shows | How |
|---|---|---|
| [AI Assist](ai-assist/) | Asking a broker in your own words: Explore steered by the answers, every change undone | video - [watch it](https://seamware.github.io/c3-demos/ai-assist/) |
| [Factory floor](factory/) | 25 entities with Relationships, locations, areas and routes; its robots at work, their values changing live | `factory/launch.sh` |
| [Boston bikes](bikes/) | Real open data: 572 bike-share stations and 13 districts from the city's CKAN portal, on the map | `bikes/launch.sh` |
| [Madrid (CDMAD)](https://github.com/SEAMWARE/c3-demo-madrid) | A smart city: Madrid's bus lines, streetlights, air quality, weather and traffic - a page that moves the world, c³ following with its alarms | its own repository |

## Running a demo

Needs: [coraine](https://github.com/SEAMWARE/coraine/blob/main/doc/installation.md) (`apt install coraine`
from https://seamware.github.io/apt), `curl`, and [c³](https://github.com/SEAMWARE/c3#try-it) built and
running. The launchers use c³'s example scripts, so c³ is checked out beside this repository:

```
seamware/
├── c3/          https://github.com/SEAMWARE/c3 - built as its README says
└── c3-demos/    this repository
```

Then:

```sh
cd seamware/c3-demos
factory/launch.sh            # or: bikes/launch.sh
```

It starts a coraine of its own, in RAM - on port 1090 (factory) or 1092 (bikes), the health port the
next one - loads the demo's entities and says where to connect: in c³, **Explore**, enter
`http://localhost:1090` and press **Connect**. Ctrl-C stops the demo and its broker.

| Variable | |
|---|---|
| `PORT` | the broker's port (the health port is `PORT`+1) |
| `C3` | the c³ checkout, when it is not `../c3` |
| `CORAINE` | the broker, when it is not `coraine` in `PATH` |

`factory/launch.sh 300` adds 300 sensors to the floor, to page through. The broker's log is
`/tmp/c3-demo-<port>.log`.

### Factory floor

25 entities - a building, its floors, docks, shelves, charging stations, robots, missions and operators -
with their Relationships, locations, areas and routes. The robots drive their missions' routes: `location`,
`speed` and `batteryLevel` change every 0.5 s, a robot at a charger charges, and a mission appears or
disappears every few seconds. In Explore: the graph, right-click a Robot for its linked entities or its
neighbourhood, **Map** for the routes; **Live · WebSocket** at the top says how the changes arrive.

### Boston bikes

The city's bike-share stations and districts, read from its CKAN portal (data.boston.gov - needs the
network; the data: ODC PDDL). In Explore, tick **District**, then **BikeStation**, press **Load**, and
**Map**: **colour by** `inDistrict →` gives each district its colour - its stations and its area.

### Madrid (CDMAD)

Its own repository, [SEAMWARE/c3-demo-madrid](https://github.com/SEAMWARE/c3-demo-madrid): a backend that
starts the broker and a page that moves the city. Run as its README says, then in c³ type `CDMAD` in the
broker field - c³ knows it by name, and connects with the demo's map view, the types to watch and its
alarms.

## Licence

Apache License 2.0 - see [LICENSE](LICENSE). The Madrid and Boston data keep their own licences.
