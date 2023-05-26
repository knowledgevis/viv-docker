# startup.sh
# Viv startup utility
cd /viv
pnpm dev --host --port 3000 &

# start python server on /data directory
cd /data
echo 'starting data server'
python -m http.server 
