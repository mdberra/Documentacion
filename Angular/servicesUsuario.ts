componentes/login/login.component.ts
-------------------------------------
import { Component, OnInit } from '@angular/core';
import { UsuarioService } from '../../services/usuario.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styles: []
})
export class LoginComponent implements OnInit {


  constructor( public usuarioService: UsuarioService ) {

   }

  ngOnInit() {
//    console.log(this.usuarioService.getUsuarios());
    this.usuarioService.getUsuarios()
      .subscribe( resp => {
          console.log(resp[0].apellido);
        }
     );
  }

}


models/usuario.model.ts
-----------------------
export class Usuario {
    constructor(
        public id: number,
        public nombre: string,
        public apellido: string,
        public email: string,
        public password: string
    ) {
    }
}

services/usuario.service.ts
---------------------------
import { Injectable } from '@angular/core';
import { Usuario } from '../models/usuario.model';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  private u: Usuario;
  private users = [];

  constructor( private http: HttpClient ) {
    this.u = new Usuario(1, 'Pepe', 'Sanchez', 'pepe.sanchez@gmail.com', 'pepito');
    this.users.push(this.u);
  }

  getUsuarios(): Observable<Usuario[]> {
    return of(this.users);
  }
	addUsuario(us:Usuario): Array<Usuario> {
    this.users.push(us);
    return this.users;
	}
/**	getUsuario(email:string):Usuario {
    Usuario uu = this.usuarios.
    return this.usuarios.
    
    map( {"email":email} );
	} */
}

store/actions/index.ts
----------------------
export * from './usuarios.actions';

store/actions/usuarios.actions.ts
---------------------------------
import { Action } from '@ngrx/store';
import { Usuario } from '../../models/usuario.model';

export const INGRESAR_USUARIOS         = '[Usuarios] Ingresar usuarios';
export const INGRESAR_USUARIOS_FAIL    = '[Usuarios] Ingresar usuarios FAIL';
export const INGRESAR_USUARIOS_SUCCESS = '[Usuarios] Ingresar usuarios SUCCESS';

export class IngresarUsuarios implements Action {
    readonly type = INGRESAR_USUARIOS;
}
export class IngresarUsuariosFail implements Action {
    readonly type = INGRESAR_USUARIOS_FAIL;

    constructor(public payload: any) {

    }
}
export class IngresarUsuariosSuccess implements Action {
    readonly type = INGRESAR_USUARIOS_SUCCESS;

    constructor(public usuarios: Usuario[]) {

    }
}

export type usuariosActions =   IngresarUsuarios |
                                IngresarUsuariosFail |
                                IngresarUsuariosSuccess;


