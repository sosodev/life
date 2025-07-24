import { Controller } from "@hotwired/stimulus"

// Creates a confetti animation within the controller's element when it connects to the DOM.
export default class extends Controller {
  connect() {
    const container = this.element
    if (getComputedStyle(container).position === 'static') {
      container.style.position = 'relative'
    }
    container.style.overflow = 'hidden'

    const confettiCount = 50
    const emojis = ['🎉', '🎊', '🎈', '✨', '⭐', '💖', '🚀']

    for (let i = 0; i < confettiCount; i++) {
      const confetti = document.createElement('div')
      confetti.innerText = emojis[Math.floor(Math.random() * emojis.length)]
      confetti.style.position = 'absolute'
      confetti.style.left = `${Math.random() * 100}%`
      confetti.style.top = `${-20 - (Math.random() * 100)}px`
      confetti.style.fontSize = `${Math.random() * 1 + 0.5}rem`
      confetti.style.transform = `rotate(${Math.random() * 360}deg)`
      confetti.style.transition = 'top 1.5s ease-in, opacity 1.5s ease-in'
      confetti.style.userSelect = 'none'
      confetti.style.pointerEvents = 'none'
      confetti.style.zIndex = '100'
      container.appendChild(confetti)

      requestAnimationFrame(() => {
        setTimeout(() => {
          confetti.style.top = `${container.offsetHeight + 20}px`
          confetti.style.opacity = '0'
        }, 10)
      })

      setTimeout(() => {
        confetti.remove()
      }, 1500)
    }
  }
}
