import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
    static targets = [ "followButton", "bookmarkButton" ]

    follow(event) {
        event.preventDefault()
        let target = this.followButtonTarget
        let user = event.currentTarget.dataset.user

        axios.post(`/api/v1/users/${user}/follow`)
            .then(res => {
                let status = res.data.status
                switch (status) {
                    case 'sign_in_first':
                        alert('Please sign in first!')
                        break
                    default:
                        target.innerHTML = status
                }
            }).catch(err => {
                alert(err.data.status)
                console.log(err.data.status)
            })
    }

    bookmark(event) {
        event.preventDefault()
        let slug = event.currentTarget.dataset.slug
        let target =  this.bookmarkButtonTarget

        axios.post(`/api/v1/stories/${slug}/bookmark`)
            .then(res => {
                let status = res.data.status
                switch (status) {
                    case 'bookmarked':
                        target.classList.add('fa-solid')
                        target.classList.remove('fa-regular')
                        break;
                    case 'unbookmark':
                        target.classList.add('fa-regular')
                        target.classList.remove('fa-solid')
                        break;
                    }
            }).catch(err => {
                console.log('error')
            })


    }
}
