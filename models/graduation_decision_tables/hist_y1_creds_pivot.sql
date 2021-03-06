with

credits as (
    select * from {{ ref('hist_y1_creds') }}
),

pivoted_credits as ( 
    select *

    from credits

    pivot (
        sum(total_credits_earned) -- total creds for each credit type
        for credit_type in ({{ credit_types_list() }}))
    as PivotTable (student_id, lastfirst, eng, math, sci, hist, forlang, elect, pe, cr, admin)
),

final as (
    select *,
    {{ is_graduating("pivoted_credits") }}

    from(pivoted_credits)
)

select * from final 