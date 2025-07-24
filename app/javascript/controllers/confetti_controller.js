import { Controller } from "@hotwired/stimulus"

// Creates a full-screen confetti animation when it connects to the DOM.
export default class extends Controller {
  connect() {
    const confettiCount = 50
    const emojis = ['🎉', '🎊', '🎈', '✨', '⭐', '💖', '🚀']

    for (let i = 0; i < confettiCount; i++) {
      const confetti = document.createElement('div')
      confetti.innerText = emojis[Math.floor(Math.random() * emojis.length)]
      confetti.style.position = 'fixed'
      confetti.style.left = `${Math.random() * 100}%`
      confetti.style.top = `${-20 - (Math.random() * 100)}px`
      confetti.style.fontSize = `${Math.random() * 1 + 0.5}rem`
      confetti.style.transform = `rotate(${Math.random() * 360}deg)`
      confetti.style.transition = 'top 1.5s ease-in, opacity 1.5s ease-in, transform 1.5s ease-out'
      confetti.style.userSelect = 'none'
      confetti.style.pointerEvents = 'none'
      confetti.style.zIndex = '100'
      document.body.appendChild(confetti)

      requestAnimationFrame(() => {
        setTimeout(() => {
          const horizontalDrift = (Math.random() - 0.5) * 200 // -100px to 100px
          const currentTransform = confetti.style.transform
          confetti.style.transform = `${currentTransform} translateX(${horizontalDrift}px)`
          confetti.style.top = `${window.innerHeight + 20}px`
          confetti.style.opacity = '0'
        }, 10)
      })

      setTimeout(() => {
        confetti.remove()
      }, 1500)
    }
  }
}
