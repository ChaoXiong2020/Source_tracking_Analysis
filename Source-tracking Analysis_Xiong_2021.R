
######植物微生物组来源模型构建步骤及说明######

#1. 为了构建植物微生物组来源模型 (Source Model of Plant Microbiome，SMPM) ，首先应该基于已有的知识体系及植物不同部位微生物群落的潜在来源
#   及互作关系构建植物微生物组来源概念模型 (即将不同部位的微生物群落设置为需要分析的目标样本及其潜在的来源)。

#2. 需要注意的是概念模型是非常重要的，需要构建符合逻辑的概念模型，比如根际土壤是根表的源是比较符合逻辑的，
#   因为土壤是植物微生物的种子库，大部分的植物微生物都是逐渐从土壤富集到根际然后进一步富集到根表和根内，这是一个逐步富集和过滤的过程，其中根际及根表是一个过滤的界面。
#   如果要把根内作为根际的源，可能就不是很符合实际，虽然根内也可能有一些来自种子的微生物可能迁移到根际中，但是这部分应该是很少的。所以需要先确定好概念模型，然后再进行下一步的分析。

#3. 根据构建好的概念模型分别对这些来源关系进行分析（所以是多次进行分析，比如根际可以作为根表的source，但同时也可以作为非根际土壤的sink）。


######溯源分析相关软件、脚本及数据准备######

#本方案涉及到的方法及脚本主要参考自SourceTracker软件的Github主页 (Knights et al., 2011) (软件及相关脚本：https://github.com/danknights/sourcetracker) 
#文件夹 “sourcetracker-master” 包括相关R脚本及数据格式，其中“ README.md ”文件中有相关使用教程及说明。
#以下内容为本方案溯源分析主要采用的分析流程，如需了解更多帮助及方法，可参考SourceTracker软件的Github主页 (https://github.com/danknights/sourcetracker) 

#1. 数据准备
#   根据metadata.txt准备实验设计的表格，至少包括以下几列：1. “ SampleID ” (样品编号，与ZOTU表对应) ，2. “ Env ” (样品分组，如植物不同的部位) ，3. “ SourceSink ” (来源及目标)。 
#   其中将需要评估的目标样本命名为sink (如探究叶表的来源，所有来自叶表的样品分组名字为sink) ，其次可能的微生物来源命名为source (如非根际土壤、根际土壤、根表等环境可能是叶表的潜在来源，其样品分组名字均为source)。
#   根据otus.txt准备ZOTU表格 (注意数值为整数，不能是相对丰度或小数)，为了加快运行速度，示例数据只保留了丰度前1000的ZOTU，仅作为数据格式参考，正常分析时可使用所有ZOTU

#2. 分析过程及脚本

# 如果在服务器QIIME中运行SourceTracker软件
# 首先需要将SourceTracker文件夹路径存储在环境变量“SOURCETRACKER_PATH”中，脚本参考可参考 “README.md” 文件中的说明。
# 例如在分析目录下运行： “echo "" >> ~/.bash_profile; echo "export SOURCETRACKER_PATH=$HOME/Desktop/sourcetracker-master" >> ~/.bash_profile; source ~/.bash_profile”  ($HOME/Desktop/sourcetracker-master为分析目录地址)
# 如果在本地虚拟机构建的QIIME中运行脚本，可直接运行，如遇报错可尝试以上步骤或参考 “README.md” 文件中的说明

#2.1 #进入分析数据所在目录（以在本地虚拟机构建的QIIME中运行脚本为例）
cd  /home/qiime/Desktop/Shared_Folder/Source_tracking_Analysis/

#2.2 根据构建的概念模型，分别运行SourceTracker脚本对模型中的各条来源关系进行计算及验证
#    例如首先探究根际微生物组的来源，如果样品涉及较多部位，此时样品可只保留根际及可能的来源样品（如非根际）
#    在metadata.txt文件中将“ SourceSink ”列下所有根际样品命名为sink，其他潜在的来源如非根际土壤品命名为source，然后进行分析。

#运行分析脚本
R --slave --vanilla --args -i otus.txt -m metadata.txt -o sourcetracker_out < sourcetracker_for_qiime.r

#2.3 根据 “ sourcetracker_out ” 输出文件夹下的分析结果，在excel中计算植物各部位微生物组的平均潜在来源比率
#    根据计算结果对概念模型进行优化并赋值，使用AI或者PPT绘制植物微生物组来源模型示意图

