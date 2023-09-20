class EducationResultBox extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        var subject = this.getAttribute("subject");
        var result = this.getAttribute("result");
        this.innerHTML = `
            <div class="info-education-result-div">
                <span>${subject}</span>
                <span>
                    ${result}
                </span>
            </div>`
    }
}

customElements.define('education-result-box', EducationResultBox);