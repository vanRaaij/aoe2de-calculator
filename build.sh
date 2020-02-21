#!/bin/sh

set -e

js="build/index.js"

elm make src/Main.elm --optimize --output=$js $@

echo "Compiled size:$(cat $js | wc -c) bytes  ($js)"
echo "Gzipped size: $(cat $js | gzip -c | wc -c) bytes"