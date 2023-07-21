# startup.sh
# Viv startup utility
cd /viv
pnpm dev --host --port 3000 &

# start python server on /data directory on port 8000
cd /data
echo 'starting data server'
python -m http.server 
