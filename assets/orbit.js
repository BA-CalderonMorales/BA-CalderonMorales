import svgPanZoom from 'https://cdn.jsdelivr.net/npm/svg-pan-zoom@3.6.1/dist/svg-pan-zoom.min.js';

const panZoom = svgPanZoom('#appSvg', {
  zoomEnabled: true,
  controlIconsEnabled: false,
  fit: true,
  center: true,
  minZoom: 0.2,
  maxZoom: 200,
  onZoom: throttle(updateFractal, 50),
  onPan: throttle(updateFractal, 100)
});

function throttle(fn, wait) {
  let last = 0;
  return (...args) => {
    const now = Date.now();
    if (now - last > wait) {
      last = now;
      fn(...args);
    }
  };
}

function getViewBox() {
  const svg = document.getElementById('appSvg');
  const [x, y, w, h] = svg.getAttribute('viewBox').split(/\s+/).map(Number);
  const zoom = panZoom.getZoom();
  return { x, y, w, h, zoom };
}

function mid(x1, y1, x2, y2) {
  return { x: (x1 + x2) / 2, y: (y1 + y2) / 2 };
}

function drawSierpinski() {
  const { x, y, w, h, zoom } = getViewBox();
  const depth = Math.min(7, Math.floor(Math.log2(zoom)) + 1);
  const layer = document.getElementById('fractalLayer');
  layer.innerHTML = '';
  const svgNS = 'http://www.w3.org/2000/svg';
  const minSize = Math.min(w, h);

  function recurse(ax, ay, bx, by, cx, cy, d) {
    if (d === 0) {
      const tri = document.createElementNS(svgNS, 'polygon');
      tri.setAttribute('points', `${ax},${ay} ${bx},${by} ${cx},${cy}`);
      tri.setAttribute('fill', `hsl(${(d * 40) % 360},80%,${50 + d * 5}%)`);
      layer.appendChild(tri);
    } else {
      const ab = mid(ax, ay, bx, by);
      const bc = mid(bx, by, cx, cy);
      const ca = mid(cx, cy, ax, ay);
      recurse(ax, ay, ab.x, ab.y, ca.x, ca.y, d - 1);
      recurse(ab.x, ab.y, bx, by, bc.x, bc.y, d - 1);
      recurse(ca.x, ca.y, bc.x, bc.y, cx, cy, d - 1);
    }
  }

  recurse(x, y + h, x + w, y + h, x + w / 2, y, depth);
}

window.updateFractal = drawSierpinski;
drawSierpinski();
