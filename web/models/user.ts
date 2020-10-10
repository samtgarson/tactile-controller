import { v4 as uuid } from 'uuid'
import jwt from 'jsonwebtoken'

const SECRET = process.env.SECRET_KEY!

export class User {
  public role: string
  public id: string

  constructor (role: string, id: string = uuid()) {
    this.role = role
    this.id = id
  }

  static fromToken (token: string) {
    try {
      const { id, role } = jwt.verify(token, SECRET) as { id: string, role: string }
      return new User(role, id)
    } catch (err) {
      return
    }
  }

  get token () {
    const { id, role } = this
    return jwt.sign({ id, role }, SECRET)
  }

  get toJSON () {
    const { token, id, role } = this
    return { token, id, role }
  }
}
