# `celestial`

A Paradise server written in Crystal

Status:

-   `master`: [![Build Status](https://travis-ci.com/paradise-celestial/celestial.svg?branch=master)](https://travis-ci.com/paradise-celestial/celestial)
-   `develop`: [![Build Status](https://travis-ci.com/paradise-celestial/celestial.svg?branch=develop)](https://travis-ci.com/paradise-celestial/celestial)

## Installation

### From Executable

1.  Download the latest stable release from [the releases page](https://github.com/paradise-celestial/celestial/releases).
2.  Place it in a folder where it won't get lost

### From Source

1.  Install [Crystal](https://crystal-lang.org/reference/installation/)
2.  `git clone https://github.com/paradise-celestial/celestial.git --depth 1`
    -   The `--depth 1` only downloads the latest source; this flag is optional
3.  In the `celestial` folder, run `shards install && shards build --release`
4.  The generated executable will be at `bin/celestial` in the `celestial` folder

## Usage

To start the server, run the `celestial` executable; the bind address will be logged. Configuration options are coming soon.

## Development

2.  Install using the [contributing](#contributing) instructions
3.  Make changes to the code
4.  Use `crystal spec` and `bin/ameba` to test and lint
5.  Continue with the contributing instructions

## Contributing

1.  Fork it (<https://github.com/paradise-celestial/celestial/fork>)
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
    - This repository uses Commitizen
    <!-- TODO: Commitizen instructions -->
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request

## Contributors

-   [microlith57](https://github.com/microlith57) - creator and maintainer
-   [neauoire](https://github.com/neauoire) - creator of original Paradise implementation; inspiration for project
