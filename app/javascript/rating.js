console.log("RATING JS LOADED");
document.addEventListener("submit", function (e) {
  const form = e.target;

  if (form.id !== "rating-form") return;

  e.preventDefault();

  const value = document.getElementById("rating-input").value;
  const imageId = document.getElementById("image-id").value;

  fetch("/api/ratings", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify({
      image_id: imageId,
      value: value
    })
  })
  .then(res => res.json())
  .then(data => {
    alert("Оценка сохранена. Средняя: " + data.average);
  });

  return false;
});