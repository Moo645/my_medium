import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
    static targets = [ "followButton" ]

    follow(event) {
        event.preventDefault()
        let target = this.followButtonTarget
        let user = event.currentTarget.dataset.user

        axios.post(`/users/${user}/follow`)
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
}
