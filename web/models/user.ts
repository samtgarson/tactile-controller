import { v4 as uuid } from 'uuid'

export class User {
  public role: string
  public id: string

  constructor (role: string, id: string = uuid()) {
    this.role = role
    this.id = id
  }

  static fromPusher ({ id: encodedId }: { id: string }): User {
    const { id, role } = JSON.parse(Buffer.from(encodedId, 'base64').toString('ascii'))
    return new User(role, id)
  }

  get encodedId (): string {
    const { id, role } = this
    return Buffer.from(JSON.stringify({ id, role })).toString('base64')
  }
}
