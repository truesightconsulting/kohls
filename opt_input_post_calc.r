# # halo effect of goal seek
# source(paste(main.path,"opt_modelinput_halo.r",sep=""),local = T)

# calculate final result
curve$value_decomp=calc_decomp(curve$sp_current)
curve$value_npv=curve$value_decomp*curve$clv
curve$value_factor_1=curve$value_decomp/curve$factor_1
if (ex.setup$optimization_type %in% c(3,5,9)) {
  curve$spend_start=curve$sp_plan
  curve$value_decomp_start=calc_decomp(curve$sp_plan)
  curve$value_npv_start=curve$value_decomp_start*curve$clv
  curve$value_factor_1_start=curve$value_decomp_start/curve$factor_1
  curve$support_start=curve$sp_plan/curve$cps
}else{
  curve$spend_start=curve$sp_min
  curve$value_decomp_start=calc_decomp(curve$sp_min)
  curve$value_npv_start=curve$value_decomp_start*curve$clv
  curve$value_factor_1_start=curve$value_decomp_start/curve$factor_1
  curve$support_start=curve$sp_min/curve$cps
}
curve$support=curve$sp_current/curve$cps
curve$value_npv_next=curve$clv*calc_decomp(curve$sp_current+ex.setup$input_increment)
curve$sp_inc=ex.setup$input_increment

# summarize result
input_sp=c("sp_current","spend_start","support","support_start","sp_inc")
output_sp=c("spend","spend_start","support","support_start","sp_inc")
input_decomp=c("value_decomp","value_npv","value_factor_1","value_decomp_start","value_npv_start","value_factor_1_start","value_npv_next")
output_decomp=c("decomp","value","factor_1","decomp_start","value_start","factor_1_start","value_next")

source(paste(main.path,"opt_modelinput_post_calc_agg.r",sep=""),local = T)

# format output
# new var 
metric_eff=c("eff1","eff1_start","mroi")
name_eff=c("ROI","Planned ROI","MROI")
f_eff=c("value/spend","value_start/spend_start","(value_next-value)/sp_inc")

# existing var
metric_reg=c("spend","decomp","value","factor_1","spend_start","decomp_start","value_start","factor_1_start","support","support_start","value_next","sp_inc")
name_reg=c("Spend","Revenue","Profit","Transactions","Planned Spend","Planned Revenue","Planned Profit","Planned Transactions","Impressions","Planned Impressions","Next Profit","Inc Spend")

# table column order 
order_all=c("spend","support","decomp","value","factor_1","eff1","spend_start","support_start","decomp_start","value_start","factor_1_start","eff1_start","value_next","sp_inc","mroi")
order_other=c("spend","spend_start","support","support_start","decomp","decomp_start","value","value_start","factor_1","factor_1_start","eff1","eff1_start","value_next","sp_inc","mroi")

# any columns to be dropped for all, excel and other tables; NAME HERE IS AFTER RENAMED!!!!!!!!!!!!!!!!!!!!!!!!!!
drop_all=c("all_name","Next Profit","Inc Spend","MROI")
drop_excel=c()
drop_other=c("Next Profit","Inc Spend","MROI")

source(paste(main.path,"opt_modelinput_post_calc_format.r",sep=""),local = T)