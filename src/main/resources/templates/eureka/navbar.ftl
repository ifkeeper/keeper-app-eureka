<h1>系统状态</h1>
<div class="row">
    <div class="col-md-6">
        <table id='instances' class="table table-condensed table-striped table-hover">
            <#if amazonInfo??>
                <tr>
                    <td>Eureka 服务</td>
                    <td>AMI: ${amiId!}</td>
                </tr>
                <tr>
                    <td>区域</td>
                    <td>${availabilityZone!}</td>
                </tr>
                <tr>
                    <td>实例ID</td>
                    <td>${instanceId!}</td>
                </tr>
            </#if>
            <tr>
                <td>环境</td>
                <td>${environment!}</td>
            </tr>
            <tr>
                <td>数据中心</td>
                <td>${datacenter!}</td>
            </tr>
        </table>
    </div>
    <div class="col-md-6">
        <table id='instances' class="table table-condensed table-striped table-hover">
            <tr>
                <td>当前系统时间</td>
                <td>${currentTime?datetime("yyyy-MM-dd'T'HH:mm:ss Z")?string("yyyy-MM-dd HH:mm:ss")}</td>
            </tr>
            <tr>
                <td>正常运行时间</td>
                <td>${upTime}</td>
            </tr>
            <tr>
                <td>是否启用租约过期</td>
                <td>${registry.leaseExpirationEnabled?c}</td>
            </tr>
            <tr>
                <td>租约阈值 (每分钟最少续约数)</td>
                <td>${registry.numOfRenewsPerMinThreshold}</td>
            </tr>
            <tr>
                <td>最后一分钟续约数量 (不含当前, 每分钟更新一次)</td>
                <td>${registry.numOfRenewsInLastMin}</td>
            </tr>
        </table>
    </div>
</div>

<#if isBelowRenewThresold>
    <#if !registry.selfPreservationModeEnabled>
        <h4 id="uptime"><font size="+1" color="red"><b>续费的门槛要低得多。自保存模式被关闭。在出现网络/其他问题时，这可能无法保护实例过期。</b></font></h4>
    <#else>
        <h4 id="uptime"><font size="+1" color="red"><b>注意! Eureka可能错误地声称实例已经出现，而实际上并没有。续费低于阈值，因此实例不会为了安全而过期.</b></font>
        </h4>
    </#if>
<#elseif !registry.selfPreservationModeEnabled>
    <h4 id="uptime"><font size="+1" color="red"><b>自保存模式被关闭。在出现网络/其他问题时，这可能无法保护实例过期。</b></font></h4>
</#if>

<h1>DS 副本</h1>
<ul class="list-group">
    <#list replicas as replica>
        <li class="list-group-item"><a href="${replica.value}">${replica.key}</a></li>
    </#list>
</ul>

