import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
    static targets = [ "clapCount" ]

    addClap(event) {
        event.preventDefault()
        let target = this.clapCountTarget
        let slug = event.currentTarget.dataset.slug
        
        axios.post(`/api/v1/stories/${slug}/clap`)
            .then(res => {
                let status = res.data.status
                switch (status) {
                    case 'sign_in_first':
                        alert('Please sign in first!')
                        break;
                    default:
                        target.innerHTML = res.data.clap
                }
            }).catch(err => {
                alert(err.data.status)
                console.log(err.data.status)
            })
    }
}
