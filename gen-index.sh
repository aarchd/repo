#!/bin/bash

PKG_DIR="PKGS"
OUTPUT="index.html"
BASE_URL="http://aarchd.who53.me/repo"

cat <<EOF > "$OUTPUT"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>aarchd</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-900 text-red-100 font-sans p-4 sm:p-8">
  <header class="flex flex-col sm:flex-row justify-center items-center gap-4 mb-6 sm:mb-8">
    <svg class="w-10 h-10 sm:w-12 sm:h-12 rounded-xl" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
      <rect width="200" height="200" rx="30" fill="#FFEBEE" />
      <g opacity=".8">
        <path d="m100 60 70 50q-70 50-140 0Z" fill="#E53935" />
        <path d="m100 50 70 50q-70 50-140 0Z" fill="#EF5350" />
        <path d="m100 40 70 50q-70 50-140 0Z" fill="#E57373" />
      </g>
    </svg>
    <h1 class="text-2xl sm:text-3xl text-red-400 font-semibold text-center">Packages</h1>
  </header>
  <div class="overflow-x-auto">
    <table class="min-w-full text-left bg-gray-800 rounded-lg shadow-lg">
      <thead class="bg-red-600 text-red-100 font-bold text-sm sm:text-base">
        <tr>
          <th class="px-4 sm:px-8 py-2 sm:py-4">Name</th>
          <th class="px-4 sm:px-8 py-2 sm:py-4">Version</th>
        </tr>
      </thead>
      <tbody>
EOF

for pkg in "$PKG_DIR"/*.pkg.tar.zst; do
  base=$(basename "$pkg" .pkg.tar.zst)
  version=$(echo "$base" | rev | cut -d- -f1-3 | rev)
  name=${base%-$version}

  cat <<EOF >> "$OUTPUT"
        <tr class="even:bg-gray-700 hover:bg-gray-600 text-sm sm:text-base">
          <td class="px-4 sm:px-8 py-2 sm:py-4"><a class="text-red-400 hover:underline" href="${BASE_URL}/${base}.pkg.tar.zst">${name}</a></td>
          <td class="px-4 sm:px-8 py-2 sm:py-4">${version}</td>
        </tr>
EOF

done

cat <<EOF >> "$OUTPUT"
      </tbody>
    </table>
  </div>
</body>
</html>
EOF

echo "Generated index.html"
