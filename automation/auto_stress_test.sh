#!/usr/bin/env bash

# 压测脚本模板中设定的压测时间应为60秒
#export jmx_template="order_auto"
#export suffix=".jmx"
#export jmx_template_filename="${jmx_template}${suffix}"

# 压测脚本中设定的压测时间应为20秒
export jmx_filename="order_auto.jmx"

# 需要在系统变量中定义jmeter根目录的位置，如下
# export jmeter_path="/your jmeter path/"

echo "自动化压测开始"

# 压测并发数列表
thread_number_array=(10 20 30)
for num in "${thread_number_array[@]}"
do
    # 生成对应压测线程的jmx文件
#    export jmx_filename="${jmx_template}_${num}${suffix}"
    # 定义jtl结果文件名与压测报告路径
    export jtl_filename="test_${num}.jtl"
    export web_report_path_name="web_${num}"

#    rm -f ${jmx_filename} ${jtl_filename}
    rm -f ${jtl_filename}
    rm -rf ${web_report_path_name}

#    cp ${jmx_template_filename} ${jmx_filename}
#    echo "生成jmx压测脚本 ${jmx_filename}"

#    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}  -e -o ${web_report_path_name} -Jthread ${num}
#
#    rm -f ${jmx_filename} ${jtl_filename}
    # JMeter 静默压测 + 生成html压测报告
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}  -Jthread=${num} -e -o ${web_report_path_name}
done
echo "自动化压测全部结束"

