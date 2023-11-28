<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductosRequest extends FormRequest
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
    public function rules(): array
    {
        return [
            //Reglas de validación
            'nombre' => 'required|min:6|',
            'descripcion' => 'required|min:10',
            'precio' => 'required|integer|gte:1',
            'categoria_id' => 'required',
        ];
    }

    public function messages(){
        return [
            'nombre.required' => 'Debe ingresar un nombre para el producto.',
            'nombre.min' => 'El nombre debe tener al menos 6 caracteres.',
            'descripcion.required' =>'Debe ingresar una descripción para el producto.',
            'modelo.min' => 'La descripción debe tener al menos 10 caracteres',
            'precio.required' => 'Debe ingresar un precio.',
            'precio.integer' => 'El precio no puede contener decimales.',
            'precio.gte' => 'El precio debe ser al menos 1.',
            'categoria_id.required'=> 'Debe seleccionar una categoría para el producto',

        ];
    }
}
