with 
credits as (
    select * from {{ ref('y1_creds_by_type_by_student')}}
),

final as (
    select *

    from credits

    pivot (
        sum(total_credits_earned) -- total creds for each credit type
        for credit_type in ({{ credit_types_list() }}))
    as PivotTable (student_id, lastfirst, eng, math, sci, hist, forlang, elect, pe, cr, admin)
)

select * from final 