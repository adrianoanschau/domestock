<?php

namespace App\Providers;

use App\Models\User;
use App\Policies;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;
use Spatie\Health\Checks\Checks;
use Spatie\Health\Facades\Health;
use Spatie\Permission\Models\Role;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        if (!$this->app->environment('local')) {
            URL::forceScheme('https');
        }

        Gate::policy(User::class, Policies\UserPolicy::class);
        Gate::policy(Role::class, Policies\RolePolicy::class);

        Health::checks([
            Checks\BackupsCheck::new(),
            Checks\CacheCheck::new(),
            Checks\DatabaseCheck::new(),
            Checks\DatabaseConnectionCountCheck::new(),
            Checks\DatabaseSizeCheck::new(),
            Checks\DatabaseTableSizeCheck::new(),
            Checks\DebugModeCheck::new(),
            Checks\EnvironmentCheck::new(),
            Checks\FlareErrorOccurrenceCountCheck::new(),
            Checks\HorizonCheck::new(),
            Checks\MeiliSearchCheck::new(),
            Checks\OptimizedAppCheck::new(),
            Checks\PingCheck::new(),
            Checks\QueueCheck::new(),
            Checks\RedisCheck::new(),
            Checks\RedisMemoryUsageCheck::new(),
            Checks\ScheduleCheck::new(),
            Checks\UsedDiskSpaceCheck::new(),
        ]);

        Paginator::defaultView('pagination::default');
    }
}
