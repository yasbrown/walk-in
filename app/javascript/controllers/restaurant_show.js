const timeSlot = document.querySelector(".time-slot");
const btnPurple = document.querySelector(".button purple")
console.log(timeSlot);

timeSlot.addEventListener("click", (event) => {
  btnPurple.classList.remove("hide");
});
