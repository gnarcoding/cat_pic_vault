curl -s "https://api.thecatapi.com/v1/images/search?mime_types=jpg" | grep -o '"url":"[^"]*' | cut -d'"' -f4 | xargs curl -s -o cat.jpg
