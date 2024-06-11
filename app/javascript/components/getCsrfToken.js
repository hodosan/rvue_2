export const getCsrfToken = () => {
  const metaElem = document.querySelector("meta[name='csrf-token']")
  if (!metaElem) {
    throw Error("meta[name=csrf-token] is not founded.")
  }
  const csrfToken = metaElem.getAttribute("content")
  if (!csrfToken) {
    throw Error("csrf token is not set")
  }
  return csrfToken
}