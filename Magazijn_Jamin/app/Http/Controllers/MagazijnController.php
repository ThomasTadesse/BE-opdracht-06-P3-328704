<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Magazijn;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Exception;

class MagazijnController extends Controller
{
    public function index(Request $request)
    {
        try {
            $startDate = $request->input('start_date') ?? null;
            $endDate = $request->input('end_date') ?? null;

            $magazijnInfo = DB::select('CALL spGetMagazijnInfo(?, ?)', [$startDate, $endDate]);
            return view('magazijn.index', ['magazijnInfo' => $magazijnInfo]);
        } catch (Exception $e) {
            Log::error('Error in magazijn index: ' . $e->getMessage());
            return redirect()->back()->with('error', 'Er is een fout opgetreden bij het ophalen van de magazijn informatie.');
        }
    }

    public function show($id)
    {
        try {
            $productInfo = DB::select('CALL spGetProductAllergenen(?)', [$id]);
            
            if (empty($productInfo)) {
                Log::info('Product not found with ID: ' . $id);
                return redirect()->route('magazijn.index')
                               ->with('error', 'Product niet gevonden');
            }

            return view('magazijn.show', ['productInfo' => $productInfo]);
        } catch (Exception $e) {
            Log::error('Error showing product details: ' . $e->getMessage());
            return redirect()->route('magazijn.index')
                           ->with('error', 'Er is een fout opgetreden bij het tonen van het product.');
        }
    }

    public function create()
    {
        try {
            $products = Product::all();
            return view('magazijn.create', ['products' => $products]);
        } catch (Exception $e) {
            Log::error('Error in create form: ' . $e->getMessage());
            return redirect()->route('magazijn.index')
                           ->with('error', 'Er is een fout opgetreden bij het laden van het formulier.');
        }
    }

    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'ProductId' => 'required|exists:Product,Id',
                'VerpakkingsEenheid' => 'required|numeric|min:0',
                'AantalAanwezig' => 'required|integer|min:0',
                'Opmerkingen' => 'nullable|string|max:255'
            ]);

            DB::beginTransaction();
            
            $magazijn = new Magazijn();
            $magazijn->ProductId = $validated['ProductId'];
            $magazijn->VerpakkingsEenheid = $validated['VerpakkingsEenheid'];
            $magazijn->AantalAanwezig = $validated['AantalAanwezig'];
            $magazijn->IsActief = true;
            $magazijn->Opmerkingen = $validated['Opmerkingen'];
            $magazijn->DatumAangemaakt = now();
            $magazijn->DatumGewijzigd = now();
            $magazijn->save();

            DB::commit();
            
            Log::info('New magazijn item created with ID: ' . $magazijn->Id);
            return redirect()->route('magazijn.index')
                           ->with('success', 'Product succesvol toegevoegd aan magazijn');
        } catch (Exception $e) {
            DB::rollBack();
            Log::error('Error storing magazijn item: ' . $e->getMessage());
            return redirect()->back()
                           ->withInput()
                           ->with('error', 'Er is een fout opgetreden bij het opslaan van het product.');
        }
    }

    public function edit($id)
    {
        try {
            $magazijn = Magazijn::findOrFail($id);
            $products = Product::all();
            return view('magazijn.edit', [
                'magazijn' => $magazijn,
                'products' => $products
            ]);
        } catch (Exception $e) {
            Log::error('Error in edit form: ' . $e->getMessage());
            return redirect()->route('magazijn.index')
                           ->with('error', 'Er is een fout opgetreden bij het laden van het formulier.');
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'VerpakkingsEenheid' => 'required|numeric|min:0',
                'AantalAanwezig' => 'required|integer|min:0',
                'Opmerkingen' => 'nullable|string|max:255'
            ]);

            DB::beginTransaction();

            $magazijn = Magazijn::findOrFail($id);
            $magazijn->VerpakkingsEenheid = $validated['VerpakkingsEenheid'];
            $magazijn->AantalAanwezig = $validated['AantalAanwezig'];
            $magazijn->Opmerkingen = $validated['Opmerkingen'];
            $magazijn->DatumGewijzigd = now();
            $magazijn->save();

            DB::commit();

            Log::info('Magazijn item updated with ID: ' . $id);
            return redirect()->route('magazijn.index')
                           ->with('success', 'Magazijn voorraad succesvol bijgewerkt');
        } catch (Exception $e) {
            DB::rollBack();
            Log::error('Error updating magazijn item: ' . $e->getMessage());
            return redirect()->back()
                           ->withInput()
                           ->with('error', 'Er is een fout opgetreden bij het bijwerken van het product.');
        }
    }

    public function destroy($id)
    {
        try {
            DB::beginTransaction();

            $magazijn = Magazijn::findOrFail($id);
            $magazijn->IsActief = false;
            $magazijn->DatumGewijzigd = now();
            $magazijn->save();

            DB::commit();

            Log::info('Magazijn item soft deleted with ID: ' . $id);
            return redirect()->route('magazijn.index')
                           ->with('success', 'Product succesvol verwijderd uit magazijn');
        } catch (Exception $e) {
            DB::rollBack();
            Log::error('Error deleting magazijn item: ' . $e->getMessage());
            return redirect()->back()
                           ->with('error', 'Er is een fout opgetreden bij het verwijderen van het product.');
        }
    }
}
