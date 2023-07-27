# startup.sh
# Viv startup utility
# note this could be modified to serve the compiled version instead by
# doing 'python -m http.server --directory /viv/sites/avivator/dist 3000'

cd /viv
pnpm dev --host --port 3000 &

# start python server on /data directory on port 8000
cd /data
echo 'starting data server'
python -m http.server 
