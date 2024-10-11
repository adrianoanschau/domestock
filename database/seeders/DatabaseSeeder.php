<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        User::factory()->create([
            'name' => 'Adriano Anschau',
            'email' => 'adriano@domestock.com',
        ]);

        $this->call([
            ShieldSeeder::class,
        ]);
    }
}
