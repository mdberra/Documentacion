1. instalar el npm install @ngrx/store

2. crear las carpetas
   . store 
     . actions
     . effects
     . reducers
     

3. ACTIONS
se crea un file por entidad con sus acciones y se informa en el index.ts para exportar todas las acciones/archivos
de acciones con el objetivo de que cuando queremos importar algo solo escribimos el index

usuarios.actions.ts
-----------------------
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
                                
index.ts
--------
export * from './usuarios.actions';


4. REDUCERS
creamos el reducers para Usuarios. Esto trabajara con varios Usuarios  y no un usuario en particular
el REDUCER recibe un estado y una action devolviendo un estado.


usuarios.reducers.ts
--------------------
import { Usuario } from '../../models/usuario.model';
import * as fromUsuarios from '../actions' ;

export interface UsuariosState {
    users: Usuario[];
    loaded: boolean;
    loading: boolean;
    error: any;
}

const estadoInicial: UsuariosState = {
    users: [],
    loaded: false,
    loading: false,
    error: null
};

export function usuariosReducer( state = estadoInicial, action: fromUsuarios.usuariosActions): UsuariosState {
    switch (action.type) {
        case fromUsuarios.INGRESAR_USUARIOS:
            return {
                ...state,
                loading: true;
            };
            
        case fromUsuarios.INGRESAR_USUARIOS_SUCCESS:
            return {
                ...state,
                loading: false,
                loaded:  true,
                users: [...action.usuarios]
            };

        case fromUsuarios.INGRESAR_USUARIOS_FAIL:
            return {
                ...state,
                loaded: false,
                loading: false,
                error: action.payload
            };

        default:
            return state;
    }
}

para exportar todos los reducers en un solo archivo hacemos

index.ts
--------
export * from './usuarios.reducers';


5. REDUCER
AppReducer  es el reducer que usa toda la aplicacion.
Se crea en el Store. O sea, cuelga de store y se llama app.reducers.ts
EL state aglomera todos los reducers, en este caso a usuariosReducer

app.reducers.ts
---------------
import * as reducers from './reducers';
import { ActionReducerMap } from '@ngrx/store';

export interface AppState {
    usuarios: reducers.UsuariosState;
}

export const appReducers: ActionReducerMap<AppState> = {
    usuarios: reducers.usuariosReducer
};


en appModule.ts agregamos en imports

import { StoreModule } from '@ngrx/store';
import { StoreDevtoolsModule } from '@ngrx/store-devtools';
import { appReducers } from './store/app.reducers';

        StoreModule.forRoot( appReducers ),
        StoreDevtoolsModule.instrument({
        maxAge: 25, // retener ultimos 25 states
        logOnly: environment.production
        }),


6. EFECTOS
por cada action se dispara un efecto.  No todas las action disparan. Solo las que queremos.
la action
. modifica el reducer y...
. ademas puede ser escuchada por un efecto
el efecto reacciona y
. puede disparar un nueva action
. puede conectarse a un servicio de angular para
  . hacer peticiones asyncronas/syncronas
  . escucha sockets
  ...
. luego notifica al efecto
. el efecto notifica a la action y con el reducer y demas

O sea, un efecto escucha actions

los EFFECTS 
. escuchan ACTION que son despachadas por el STORE
. simplifica la logica de los componentes asi quedan lo mas sencillo posible
. permite comunicarse fuera del ecosistema de Angular (http, sockets, tareas asyncronas)




    componente.reducer.ts con el reducer
        import * as fromContador from './contador.actions';

        export function contadorReducer(state, action: fromContador.actions) {
            switch (action.type) {
                case fromContador.INICIAR:
                    return 55;

                case fromContador.INCREMENTAR:
                    return state + 1;
    
                default:
                    return state;
            }
        }
2. en app.module.ts agregar en imports
    StoreModule.forRoot({ numero: contadorReducer }),
    StoreDevtoolsModule.instrument({
      maxAge: 25, // Retains last 25 states
      logOnly: environment.production, // Restrict extension to log-only mode
    })
3. crear app.reducers.ts con
    export interface AppState {
        numero: number;
        cadena: string;
    }
4. en todo los componentes.ts que necesito agregar
    import * as fromContador from './contador/contador.actions';

    constructor( private store: Store<AppState>) {
        this.store.select('numero').subscribe(c => this.contador = c);
        this.store.dispatch(new fromContador.IniciarAction());
    }
        o
    constructor(private store: Store<AppState>) { }
    ngOnInit() {
        this.store.select('numero').subscribe(n => this.contador = n);
    }

    incrementar() {
        this.store.dispatch(new fromContador.IncrementarAction());
    }
