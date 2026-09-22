const toggle = document.querySelector("#menuToggle");
const nav = document.querySelector("#nav");
toggle.addEventListener("click", () => {
  const open = nav.classList.toggle("open");
  toggle.setAttribute("aria-expanded", String(open));
  toggle.textContent = open ? "✕" : "☰";
});
document.querySelectorAll("nav a").forEach((a) =>
  a.addEventListener("click", () => {
    nav.classList.remove("open");
    toggle.setAttribute("aria-expanded", "false");
    toggle.textContent = "☰";
  }),
);
const data = {
  interpreting: [
    "🇬🇧 💬 🇪🇸",
    "English ↔ Spanish Interpreting",
    "Friendly support with appointments, official visits, and communication with local businesses.",
  ],
  van: [
    "🚐",
    "Large Van & Collection Service",
    "Van service for furniture collections, deliveries, house clearances, and other collection needs.",
  ],
  airport: [
    "✈️",
    "Airport Transfers",
    "Airport runs, collection and drop-off, and luggage assistance.",
  ],
  parking: [
    "🅿️",
    "Secure Private Parking",
    "Private parking based in Xàtiva for airport trips and longer periods away.",
  ],
};
const modal = document.querySelector("#modal");
const close = document.querySelector("#close");
const icon = document.querySelector("#modalIcon");
const title = document.querySelector("#modalTitle");
const text = document.querySelector("#modalText");
let previous;
document.querySelectorAll(".details").forEach((button) =>
  button.addEventListener("click", () => {
    const item = data[button.dataset.service];
    if (!item) return;
    previous = document.activeElement;
    icon.textContent = item[0];
    title.textContent = item[1];
    text.textContent = item[2];
    modal.hidden = false;
    document.body.style.overflow = "hidden";
    close.focus();
  }),
);
function hide() {
  modal.hidden = true;
  document.body.style.overflow = "";
  if (previous) previous.focus();
}
close.addEventListener("click", hide);
modal.addEventListener("click", (e) => {
  if (e.target === modal) hide();
});
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape" && !modal.hidden) hide();
});
document.querySelector("#year").textContent = new Date().getFullYear();

// Auto-hide success message banner after 3 seconds
const banner = document.getElementById('successBanner');
if (banner) {
  setTimeout(() => {
    banner.style.opacity = '0';
    setTimeout(() => banner.remove(), 500); // Smoothly removes element after fade out
  }, 3000);
}