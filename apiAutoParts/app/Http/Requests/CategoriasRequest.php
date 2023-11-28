<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CategoriasRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules()
    {
        return [
            'nombre' => 'required|min:3|unique:categorias,nombre',
        ];
    }

    public function messages(){
        return [
            'nombre.required' => 'Debe ingresar un nombre para la categoría',
            'nombre.min' => 'El nombre debe tener al menos 3 carácteres',
            'nombre.unique' =>'La categoría :input ya existe, no se puede volver a agregar',
        ];
    }
}
